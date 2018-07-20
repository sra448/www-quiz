const functions = require("firebase-functions");
const gcs = require("@google-cloud/storage")();
const spawn = require("child-process-promise").spawn;
const path = require("path");
const os = require("os");
const fs = require("fs");

exports.resize = functions.storage.object().onFinalize(object => {
  const fileBucket = object.bucket;
  const filePath = object.name;
  const contentType = object.contentType;
  const fileName = path.basename(filePath);

  const bucket = gcs.bucket(fileBucket);
  const tempFilePath = path.join(os.tmpdir(), fileName);
  const metadata = {
    contentType: contentType
  };

  return bucket
    .file(filePath)
    .download({
      destination: tempFilePath
    })
    .then(() => {
      return spawn("convert", [
        tempFilePath,
        "-resize",
        "1200x1200",
        tempFilePath
      ]);
    })
    .then(() => {
      const thumbFileName = fileName;
      const thumbFilePath = path.join(path.dirname(filePath), thumbFileName);
      return bucket.upload(tempFilePath, {
        destination: thumbFilePath,
        metadata: metadata
      });
    })
    .then(() => fs.unlinkSync(tempFilePath))
    .catch(err => console.log("err", err));
});
