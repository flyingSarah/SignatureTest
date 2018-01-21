#include "PostSignature.h"

PostSignature::PostSignature(QObject *parent) : QObject(parent) {}

QJsonDocument PostSignature::parseData(QJsonArray gesture, int time, int tries)
{
    QJsonObject signatureObj;
    signatureObj.insert("gesture", gesture);
    signatureObj.insert("time", time);
    signatureObj.insert("tries", tries);

    QJsonObject jsonObj;
    jsonObj.insert("signature", signatureObj);

    QJsonDocument jsonDoc(jsonObj);

    return jsonDoc;
}

bool PostSignature::sendPostRequest(QJsonDocument data)
{
    //TODO: implement this function
    qDebug() << data;
    return false;
}
