import Router, { Application } from "express";
import userController from "../controllers/user.controller";

const userRouter: Application = Router();

userRouter.get("/exists/:phone_no", userController.exists);
userRouter.post("/register", userController.register);
userRouter.post("/apply_for_guide", userController.applyForGuide);

export default userRouter;
