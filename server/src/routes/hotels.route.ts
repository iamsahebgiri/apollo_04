import Router, { Application } from "express";
import hotelController from "../controllers/hotel.controller";

const hotelsRouter: Application = Router();

hotelsRouter.get("/getAll", hotelController.getAll);
hotelsRouter.post("/place_by_id", hotelController.getPlaceById);

export default hotelsRouter;
