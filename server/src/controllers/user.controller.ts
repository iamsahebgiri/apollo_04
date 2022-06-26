import { NextFunction, Request, Response } from "express";
import billingAccountModel from "../database/models/billingAccount.model";
import userModel from "../database/models/user.model";

const userController = {
  async register(req: Request, res: Response, next: NextFunction) {
    const { name, phone, email, bio, avatar } = req.body;
    const user = new userModel({
      name,
      phone,
      email,
      bio,
      avatar,
      phoneVerified: true,
    });
    try {
      const userData = await user.save();
      const billingAccount = new billingAccountModel({
        phone,
        billingAccountId: `${phone}@ghumo`,
      });

      await billingAccount.save();

      res.json({
        res: true,
        userData,
      });
    } catch (error) {
      next(error);
    }
  },

  exists(req: Request, res: Response, next: NextFunction) {
    const { phone_no } = req.params;

    if (phone_no.length == 10) {
      userModel.exists({ phone: phone_no }, async (error, result) => {
        if (error) next(error);
        if (result) {
          const userData = await userModel.findOne({ phone: phone_no });
          res.json({
            res: true,
            userData,
          });
        } else {
          res.json({
            res: false,
            msg: "User not registered!",
          });
        }
      });
    } else {
      res.json({
        res: false,
        msg: "Invalid Phone number",
      });
    }
  },

  async applyForGuide(req: Request, res: Response, next: NextFunction) {
    const { phone_no, perHourPrice, place_id } = req.body;
    const user = await userModel.findOne({ phone: phone_no });
    if (user != null) {
      if (user.userType !== "guide") {
        userModel.updateOne(
          { phone: phone_no },
          { perHourPrice, $push: { placeIds: place_id } }
        );
        res.json({
          res: true,
          msg: "Your request has been submitted successfully. Please keep patience till we verify your identity!",
        });
      } else {
        res.json({
          res: false,
          msg: "User is already a guide!",
        });
      }
    } else {
      res.json({
        res: false,
        msg: "User not registered!",
      });
    }
  },

  async activateBillingAccount(
    req: Request,
    res: Response,
    next: NextFunction
  ) {
    const { phone } = req.body;
    try {
      const billingAc = await billingAccountModel.findOne({ phone });
      if (billingAc !== null) {
        if (billingAc.activated) {
          res.json({
            res: false,
            msg: "Your billing account is already activated",
          });
        } else {
          await billingAccountModel.updateOne(
            {
              phone,
            },
            { activated: true, walletBalance: 500 }
          );

          await userModel.updateOne(
            { phone },
            { billingAccountId: `${phone}@ghumo` }
          );

          res.json({
            res: true,
            msg: "Billing account activated successfully! 500 GT tokens has been credited to your wallet.",
          });
        }
      } else {
        res.json({
          res: false,
          msg: "No billing account found! Invalid user.",
        });
      }
    } catch (error) {
      next(error);
    }
  },

  async getBillingAccount(req: Request, res: Response, next: NextFunction) {
    const { phone } = req.body;
    try {
      const billingAc = await billingAccountModel.findOne({ phone });
      if (!billingAc) {
        res.json({
          res: false,
          msg: "User doen't have a billing account.",
        });
      } else if (!billingAc.activated) {
        res.json({
          res: false,
          msg: "User's billing account is not activated.",
        });
      } else {
        res.json({
          res: true,
          billingAccount: billingAc,
        });
      }
    } catch (error) {
      next(error);
    }
  },
};

export default userController;
