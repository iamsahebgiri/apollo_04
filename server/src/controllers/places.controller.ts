import { NextFunction, Request, Response } from "express";
import placesModel from "../database/models/places.model";
import { calculateDistance } from "../helpers";

const placesController = {
  async getAll(req: Request, res: Response, next: NextFunction) {
    const { lat, lng } = req.query;
    console.log({ lat, lng });

    const allPlaces = await placesModel.find({});
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
};

export default placesController;
