import { Document, model, ObjectId, Schema } from "mongoose";

export interface BookingsInterface extends Document {
  _id: ObjectId;
}

const Booking: Schema = new Schema({
  bookedBy: {
    type: String,
    required: true,
  },
  bookedFor: {
    type: String,
    required: true,
  },
  bookingDate: {
    type: String,
    default: new Date(),
  },
  placeId: {
    type: String,
    required: true,
  },
  status: {
    type: String,
    enum: ["confirmed", "cancelled", "pending"],
    default: "pending",
  },
});

export default model("booking", Booking);
