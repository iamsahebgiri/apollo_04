export const ISDEV = process.env.NODE_ENV === "development";
export const PORT = process.env.PORT || 80;
export const dbUri = ISDEV
  ? "mongodb://localhost:27017/test"
  : `mongodb+srv://admin:${process.env.DB_PASS}@cluster0.exwma.mongodb.net/?retryWrites=true&w=majority`;
