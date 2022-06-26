import { Document, model, ObjectId, Schema } from "mongoose";

export interface BillingAccountInterface extends Document {
  _id: ObjectId;
}

const BillingAccount: Schema = new Schema({
  phone: {
    type: String,
    required: true,
  },
  billingAccountId: {
    type: String,
    required: true,
  },
  walletBalance: {
    type: String,
    default: 0,
  },
  invoices: {
    type: Array,
    default: [],
  },
  activated: {
    type: Boolean,
    default: false,
  },
});

export default model("billingAccount", BillingAccount);
