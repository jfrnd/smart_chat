"use strict";

import { v4 as uuidv4 } from "uuid";

import { Question } from "./question";
import {
  createQarsWithQuestions,
  sendNewQarsCreatedPushNotification,
} from "./qar";
import { makeRecentQarsVisible } from "./qar";

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

import { Subscription } from "./subscription";

admin.initializeApp();

export const qarCreator = functions
  .region("europe-west3")
  .pubsub.schedule("*/30 * * * *")
  .onRun(async (context) => {
    const curDate = admin.firestore.Timestamp.now().toDate().toDateString(); // "Mon Jun 28 2021"
    const curTime = admin.firestore.Timestamp.now()
      .toDate()
      .toTimeString()
      .substr(0, 5); // "HH:MM"

    const subscriptions = await admin
      .firestore()
      .collectionGroup("subscriptions")
      .where("status", "==", "active")
      .where("triggers.daily", "==", curTime)
      .get();

    const jobs: Promise<any>[] = [];

    subscriptions.forEach(async (snapshot) => {
      const subscription: Subscription = snapshot.data() as Subscription;

      const job = executeQarCreationTasks(
        subscription.chatBotId,
        subscription.userId
      )
        .then(() =>
          snapshot.ref.update({
            lastSent: curDate,
            lastResult: "success",
          })
        )
        .catch((err) => {
          console.log(err);
          return snapshot.ref.update({
            lastSent: curDate,
            lastResult: "error",
          });
        });
      jobs.push(job);
    });
    return await Promise.all(jobs);
  });

async function executeQarCreationTasks(
  chatBotId: string,
  userId: string
): Promise<any> {
  const sessionId = uuidv4();

  const questions: Question[] = await admin
    .firestore()
    .collection("chatbots")
    .doc(chatBotId)
    .collection("questions")
    .orderBy("position")
    .get()
    .then((snapshot) => snapshot.docs.map((it) => it.data() as Question));

  return createQarsWithQuestions(userId, sessionId, questions).then((_) =>
    makeRecentQarsVisible(sessionId, userId, chatBotId).then((_) =>
      sendNewQarsCreatedPushNotification(userId, questions[0])
    )
  );
}
