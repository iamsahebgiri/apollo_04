import Router, { Application } from "express";
import guideRouter from "./guide.route";
import placesRouter from "./places.route";
import userRouter from "./user.route";
const mainRouter: Application = Router();

mainRouter.use("/user", userRouter);
mainRouter.use("/places", placesRouter);
mainRouter.use("/guide", guideRouter);

export default mainRouter;
