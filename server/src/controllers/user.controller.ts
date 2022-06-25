import { NextFunction, Request, Response } from "express";
import userModel from "../database/models/user.model";

const userController = {
  async register(req: Request, res: Response, next: NextFunction) {
    const { name, phone, email, bio } = req.body;
    const user = new userModel({ name, phone, email, bio });
    const userData = await user.save();
    res.json({
      res: true,
      userData,
    });
  },

  exists(req: Request, res: Response, next: NextFunction) {
    const { phone_no } = req.params;
    console.log(phone_no);

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
};

export default userController;
