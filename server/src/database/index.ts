import colors from "ansi-colors";
import { connect, Connection, connection } from "mongoose";
import dotenv from "dotenv";
import { dbUri } from "../constants";
dotenv.config();

// const uri: string = `mongodb+srv://${process.env.USERNAME}:${process.env.PASS}@mycluster.sxsst.mongodb.net/myFirstDatabase?retryWrites=true&w=majority`; //! requires USERNAME & PASS in .env

const uri: string = dbUri;

connect(uri);

const db: Connection = connection;

db.on("open", () => {
  console.log(colors.bgCyan("\tConnected to the database successfully"));
});

db.once("error", () => {
  console.error(
    colors.red("\tThere was some problem connecting to the database")
  );
});
