import { NextFunction, Request, Response } from "express";
import billingAccountModel from "../database/models/billingAccount.model";

const transactController = {
  async sendTokens(req: Request, res: Response, next: NextFunction) {
    const { phone, billingAccountId, transferAmount } = req.body;
    try {
      const senderAc = await billingAccountModel.findOne({ phone });
      const receiverAc = await billingAccountModel.findOne({
        billingAccountId,
      });

      if (!senderAc || !receiverAc)
        res.json({
          res: false,
          msg: "Sender or receiver details doesnt match our records.",
        });
      else if (senderAc.walletBalance < transferAmount)
        res.json({
          res: false,
          msg: "Insufficient wallet balance.",
        });
      else {
        await billingAccountModel.updateOne(
          { phone },
          { $inc: { walletbalance: -transferAmount } }
        );
        await billingAccountModel.updateOne(
          { phone },
          { $inc: { walletbalance: transferAmount } }
        );

        res.json({
          res: true,
          msg: "Yay! Transaction Successful!",
        });
      }
    } catch (error) {
      next(error);
    }
  },
};

export default transactController;
