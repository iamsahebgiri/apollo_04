import Router, { Application } from "express";
import userController from "../controllers/user.controller";

const userRouter: Application = Router();

userRouter.get("/exists/:phone_no", userController.exists);

export default userRouter;
