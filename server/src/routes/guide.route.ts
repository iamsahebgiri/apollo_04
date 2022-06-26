import Router, { Application } from "express";
import guideController from "../controllers/guide.controller";

const guideRouter: Application = Router();

guideRouter.post("/book", guideController.book);
guideRouter.get("/get_guides/:place_id", guideController.getGuidesByPlaceId);
guideRouter.get("/bookings/:phone_no", guideController.getAllBookings);

export default guideRouter;
