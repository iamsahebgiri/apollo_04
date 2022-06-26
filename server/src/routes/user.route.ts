import Router, { Application } from "express";
import userController from "../controllers/user.controller";

const userRouter: Application = Router();

userRouter.get("/exists/:phone_no", userController.exists);
userRouter.post("/register", userController.register);
userRouter.post("/apply_for_guide", userController.applyForGuide);
userRouter.post("/activate_billing", userController.activateBillingAccount);
userRouter.post("/get_billing_acc", userController.getBillingAccount);

export default userRouter;
