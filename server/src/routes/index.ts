import Router, { Application } from "express";
import guideRouter from "./guide.route";
import hotelsRouter from "./hotels.route";
import placesRouter from "./places.route";
import restaurantsRouter from "./restaurants.route";
import TransactRouter from "./transact.route";
import userRouter from "./user.route";
const mainRouter: Application = Router();

mainRouter.use("/user", userRouter);
mainRouter.use("/places", placesRouter);
mainRouter.use("/restaurants", restaurantsRouter);
mainRouter.use("/hotels", hotelsRouter);
mainRouter.use("/transact", TransactRouter);
mainRouter.use("/guide", guideRouter);

export default mainRouter;
