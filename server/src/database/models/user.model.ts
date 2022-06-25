import { Document, model, ObjectId, Schema } from "mongoose";

export interface UserInterface extends Document {
  _id: ObjectId;
  name: string;
  email: string;
  phone: string;
  bio: string;
  userType: ["user", "guide", "merchant"];
  avatar: string;
  emailVerified: boolean;
  phoneVerified: boolean;
  billingAccountId: string;
  guideAwaitingApproval: boolean;
}

const User: Schema = new Schema({
  name: { type: String, required: true },
  email: { type: String, required: false },
  phone: { type: String, required: true },
  avatar: {
    type: String,
    default: "https://avatar.tobi.sh/tobiaslins.svg?text=TL",
  },
  userType: {
    type: String,
    default: "user",
  },
  bio: {
    type: String,
    required: false,
  },
  emailVerified: {
    type: Boolean,
    default: false,
  },
  phoneVerified: {
    type: Boolean,
    default: false,
  },
  billingAccountId: {
    type: String,
    required: false,
  },
  guideAwaitingApproval: {
    type: Boolean,
    default: false,
  },
});

export default model("user", User);
