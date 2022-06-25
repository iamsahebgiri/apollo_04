import Router, { Application } from "express";
import placesRouter from "./places.route";
import userRouter from "./user.route";
const mainRouter: Application = Router();

mainRouter.use("/user", userRouter);
mainRouter.use("/places", placesRouter);

export default mainRouter;
