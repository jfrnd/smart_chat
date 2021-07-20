import * as admin from "firebase-admin";

export async function sendPushNotificationToUser(
  token: string,
  title: string,
  body: string,
  data?: { [key: string]: string } | undefined
): Promise<any> {
  const message: admin.messaging.Message = {
    token: token,
    notification: {
      title: title,
      body: body,
    },
    data: data,
  };

  return admin
    .messaging()
    .send(message)
    .then((response) => {
      // Response is a message ID string.
      console.log("Successfully sent message:", response);
      return { success: true };
    })
    .catch((error) => {
      return { error: error.code };
    });
}
