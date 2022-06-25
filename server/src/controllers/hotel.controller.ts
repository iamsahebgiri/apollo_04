import { NextFunction, Request, Response } from "express";
import hotelsModel from "../database/models/hotels.model";
import { calculateDistance } from "../helpers";

const hotelController = {
  async getAll(req: Request, res: Response, next: NextFunction) {
    const { lat, lng, dham } = req.query;
    const allPlaces = await hotelsModel.find({ dham });
    for (let i = 0; i < allPlaces.length; i++) {
      allPlaces[i]["distance"] = calculateDistance(
        Number(lat),
        Number(lng),
        allPlaces[i].geometry.location.lat,
        allPlaces[i].geometry.location.lng,
        "K"
      );
    }

    allPlaces.sort(function (a, b) {
      return a.distance - b.distance;
    });

    res.json({
      allPlaces,
      msg: "Places returned!",
    });
  },
  async getPlaceById(req: Request, res: Response, next: NextFunction) {
    const { id } = req.body;
    const place = await hotelsModel.findOne({ place_id: id });
    if (place !== null)
      res.json({
        res: true,
        place,
      });
    else
      res.json({
        res: false,
        msg: "Incorrect place Id",
      });
  },
};

export default hotelController;
