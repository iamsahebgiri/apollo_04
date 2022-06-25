import { Document, model, ObjectId, Schema } from "mongoose";

export interface StudentInterface extends Document {
  _id: ObjectId;
  name: string;
  email: string;
  password: string;
  phone: string;
  avatar: string;
  emailVerified: boolean;
  phoneVerified: boolean;
  billingAccountId: string;
}

const Student: Schema = new Schema({
  name: { type: String, required: true },
  email: { type: String, required: true },
  password: { type: String, required: true },
  phone: { type: String, required: false },
  avatar: {
    type: String,
    default: "https://avatar.tobi.sh/tobiaslins.svg?text=TL",
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
});

export default model("student", Student);
