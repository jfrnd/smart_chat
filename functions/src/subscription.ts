import * as admin from "firebase-admin";

export interface Subscription extends admin.firestore.DocumentData {
  documentId: string;
  chatBotId: string;
  createdAt: FirebaseFirestore.Timestamp;
  status: string;
  triggers: any;
  userId: string;
}
