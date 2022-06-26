import { Document, model, ObjectId, Schema } from "mongoose";

interface location {
  lat: Number;
  lng: Number;
}

interface geometry {
  location: location;
}

interface openingHours {
  open_now: boolean;
}

interface photos {
  height: number;
  photo_reference: string;
  width: number;
}

export interface RestaurantsInterface extends Document {
  _id: ObjectId;
  bussiness_status: string;
  geometry: geometry;
  icon: string;
  icon_background_color: string;
  icon_mask_base_uri: string;
  name: string;
  opening_hours: openingHours;
  photos: Array<photos>;
  place_id: string;
  rating: number;
  scope: string;
  types: Array<string>;
  user_ratings_total: number;
  vicinity: string;
}

const Restaurant: Schema = new Schema({
  bussiness_status: {
    type: String,
  },
  geometry: {
    type: Object,
  },
  icon: {
    type: String,
  },
  icon_background_color: {
    type: String,
  },
  icon_mask_base_uri: {
    type: String,
  },
  name: {
    type: String,
  },
  opening_hours: {
    type: Object,
  },
  photos: {
    type: Array<Object>,
  },
  place_id: {
    type: String,
  },
  rating: {
    type: String,
  },
  scope: {
    type: String,
  },
  types: {
    type: Array<String>,
  },
  user_ratings_total: {
    type: String,
  },
  vicinity: {
    type: String,
  },
});

export default model("restaurant", Restaurant);
