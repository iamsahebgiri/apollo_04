import Router, { Application } from "express";
import restaurantController from "../controllers/restaurant.controller";

const restaurantsRouter: Application = Router();

restaurantsRouter.get("/getAll", restaurantController.getAll);
restaurantsRouter.post("/place_by_id", restaurantController.getPlaceById);

export default restaurantsRouter;
