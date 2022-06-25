import { NextFunction, Request, Response } from "express";
import bookingsModel from "../database/models/bookings.model";
import userModel from "../database/models/user.model";

const guideController = {
  async book(req: Request, res: Response, next: NextFunction) {
    const { bookedBy, bookedFor, placeId } = req.body;

    try {
      const user = await userModel.findOne({ phone: bookedBy });
      if (user !== null) {
        if (user.userType === "guide") {
          res.json({
            res: false,
            msg: "Booking Unsuccessful!",
          });
        } else {
          const booking = new bookingsModel({ bookedBy, bookedFor, placeId });
          const doc = await booking.save();
          res.json({
            res: true,
            msg: "Booking queued!",
            booking: doc,
          });
        }
      } else {
        res.json({
          res: true,
          msg: "User not registered!",
        });
      }
    } catch (error) {
      next(error);
    }
  },

  async getAllBookings(req: Request, res: Response, next: NextFunction) {
    const { phone_no } = req.params;

    try {
      const user = await userModel.findOne({ phone: phone_no });
      if (user !== null) {
        if (user.userType === "guide") {
          const bookings = await bookingsModel.find({ bookedFor: phone_no });
          res.json({
            res: true,
            bookings,
          });
        } else {
          const bookings = await bookingsModel.find({ bookedBy: phone_no });
          res.json({
            res: true,
            bookings,
          });
        }
      } else {
        res.json({
          res: true,
          msg: "User not registered!",
        });
      }
    } catch (error) {
      next(error);
    }
  },

  async updateBooking(req: Request, res: Response, next: NextFunction) {
    const { id, phone_no, status } = req.body;
    try {
      const user = await userModel.findOne({ phone: phone_no });
      if (user !== null) {
        if (user.userType === "guide") {
          await bookingsModel.findByIdAndUpdate(id, { status });
          const booking = await bookingsModel.findById(id);
          res.json({
            res: true,
            booking,
          });
        } else {
          res.json({
            res: true,
            msg: "User can't change status!",
          });
        }
      } else {
        res.json({
          res: true,
          msg: "User not registered!",
        });
      }
    } catch (error) {
      next(error);
    }
  },
  async deleteBooking(req: Request, res: Response, next: NextFunction) {
    const { id, phone_no } = req.body;
    try {
      await bookingsModel.deleteOne({ id });
      res.json({
        res: true,
        msg: "OK",
      });
    } catch (error) {
      next(error);
    }
  },
};

export default guideController;
