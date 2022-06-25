import Router, { Application } from "express";
import placeController from "../controllers/places.controller";

const placesRouter: Application = Router();

placesRouter.get("/getAll", placeController.getAll);
placesRouter.post("/place_by_id", placeController.getPlaceById);

export default placesRouter;
