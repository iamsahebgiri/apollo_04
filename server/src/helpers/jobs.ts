import cron from "node-cron";
import userModel from "../database/models/user.model";

cron.schedule("0 1 * * *", async () => {
  const users = await userModel.find({ guideAwaitingApproval: true });
  console.log("Running cron jobs on", new Date().toLocaleDateString());

  for (let user of users) {
    await userModel.updateOne(
      { phone: user.phone },
      {
        billingAccountId: `${user.phone}@ghumo`,
        guideAwaitingApproval: false,
        userType: "guide",
      }
    );
  }
});
