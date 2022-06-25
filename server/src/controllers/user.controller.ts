import { NextFunction, Request, Response } from "express";
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
    const userData = await user.save();
    res.json({
      res: true,
      userData,
    });
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
    const { phone_no } = req.body;
    const user = await userModel.findOne({ phone: phone_no });
    if (user != null) {
      if (user.userType !== "guide") {
        user.guideAwaitingApproval = true;
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
};

export default userController;
