import * as admin from "firebase-admin";

export interface ChatBot extends admin.firestore.DocumentData {
  documentId: string;
  createdAt: FirebaseFirestore.Timestamp;
  createdBy: string;
  imageUrl: string;
  translations: any;
  updatedAt: FirebaseFirestore.Timestamp;
  updatedBy: string;
  triggers: any;
}
