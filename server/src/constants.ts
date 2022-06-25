export const ISDEV = process.env.ISDEV;
export const PORT = 8000;
export const dbUri = ISDEV
  ? "mongodb://localhost:27017/test"
  : `mongodb+srv://admin:${process.env.DB_PASS}@cluster0.exwma.mongodb.net/?retryWrites=true&w=majority`;
