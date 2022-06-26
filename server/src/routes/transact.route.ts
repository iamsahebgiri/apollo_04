import Router, { Application } from "express";
import TransactController from "../controllers/transact.controller";

const TransactRouter: Application = Router();

TransactRouter.post("/send_tokens", TransactController.sendTokens);

export default TransactRouter;
