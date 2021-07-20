import * as admin from "firebase-admin";

export interface Question extends admin.firestore.DocumentData {
    documentId: string
    chatBotId: string
    createdAt: FirebaseFirestore.Timestamp
    createdBy: string
    digits: string | undefined
    maxVal: number
    minVal: number
    multiSelection: boolean
    position: number
    translations: any
    type: string
    unit: string | undefined
    updatedAt: FirebaseFirestore.Timestamp
    updatedBy: string
}