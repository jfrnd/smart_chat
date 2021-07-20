import * as admin from "firebase-admin";
import { Question } from "./question";
import { v4 as uuidv4 } from "uuid";
import { ChatBot } from "./chatbot";
import { sendPushNotificationToUser } from "./push_notification";

export interface Qar extends admin.firestore.DocumentData {
  documentId: string;
  sessionId: string;
  position: number;
  chatBotId: string;
  questionId: string;
  createdBy: string;
  answerItemIds: string[];
  isAnswered: boolean;
  isVisible: boolean;
  reactionItemId: string;
  createdAt: FirebaseFirestore.Timestamp;
  visibleSince: FirebaseFirestore.Timestamp | null;
}

export function createQar(qar: Qar): Promise<FirebaseFirestore.WriteResult> {
  const userId: string = qar.createdBy;

  return admin
    .firestore()
    .collection("users")
    .doc(userId)
    .collection("chatbots")
    .doc(qar.chatBotId)
    .collection("qars")
    .doc(qar.documentId)
    .set({
      documentId: qar.documentId,
      position: qar.position,
      sessionId: qar.sessionId,
      chatBotId: qar.chatBotId,
      questionId: qar.questionId,
      createdBy: qar.createdBy,
      answerItemIds: qar.answerItemIds,
      isAnswered: qar.isAnswered,
      isVisible: qar.isVisible,
      reactionItemId: qar.reactionItemId,
      createdAt: qar.createdAt,
      visibleSince: qar.visibleSince,
    });
}

export function makeQarVisible(
  qar: Qar,
  timeStamp: FirebaseFirestore.Timestamp
): Promise<FirebaseFirestore.WriteResult> {
  const userId: string = qar.createdBy;
  return admin
    .firestore()
    .collection("users")
    .doc(userId)
    .collection("chatbots")
    .doc(qar.chatBotId)
    .collection("qars")
    .doc(qar.documentId)
    .update({
      isVisible: true,
      visibleSince: timeStamp,
    });
}

export async function createQarsWithQuestions(
  userId: string,
  sessionId: string,
  questions: Question[]
): Promise<FirebaseFirestore.WriteResult[]> {
  const jobs: Promise<FirebaseFirestore.WriteResult>[] = [];

  const now = admin.firestore.Timestamp.now();

  const chatBotId: string = questions[0].chatBotId;

  const questionIds: string[] = questions.map((it) => it.documentId);

  let position = 0;

  questionIds.forEach((questionId) => {
    const qar: Qar = {
      position: position,
      documentId: uuidv4(),
      sessionId: sessionId,
      chatBotId: chatBotId,
      questionId: questionId,
      createdBy: userId,
      answerItemIds: [],
      isAnswered: false,
      isVisible: position == 0,
      reactionItemId: "",
      createdAt: now,
      visibleSince: position == 0 ? admin.firestore.Timestamp.now() : null,
    };

    const job = createQar(qar);
    jobs.push(job);
    position++;
  });

  return await Promise.all(jobs);
}

export async function makeRecentQarsVisible(
  sessionId: string,
  userId: string,
  chatBotId: string
): Promise<any> {
  const jobs: Promise<any>[] = [];

  const oldInvisibleQars = await admin
    .firestore()
    .collection("users")
    .doc(userId)
    .collection("chatbots")
    .doc(chatBotId)
    .collection("qars")
    .where("sessionId", "!=", sessionId)
    .where("isVisible", "==", false)
    .get();

  oldInvisibleQars.forEach((document) => {
    const qar: Qar = document.data()! as Qar;
    const job = makeQarVisible(qar, qar.createdAt);
    jobs.push(job);
  });

  return await Promise.all(jobs);
}

export async function sendNewQarsCreatedPushNotification(
  userId: string,
  question: Question
): Promise<any> {
  const jobs: Promise<any>[] = [];

  const userDoc = await admin.firestore().collection("users").doc(userId).get();
  const { token, languageCode } = userDoc.data()!;

  const chatBot: ChatBot = await admin
    .firestore()
    .collection("chatbots")
    .doc(question.chatBotId)
    .get()
    .then((snapshot) => snapshot.data() as ChatBot);

  const chatBotName: string =
    languageCode in chatBot.translations
      ? chatBot.translations[languageCode]
      : chatBot.translations[Object.keys(chatBot.translations)[0]];

  const firstQuestion: string =
    languageCode in question.translations
      ? question.translations[languageCode]
      : question.translations[Object.keys(question.translations)[0]];

  jobs.push(
    sendPushNotificationToUser(token, chatBotName, firstQuestion, {
      imageUrl: chatBot.imageUrl,
    })
  );
}
