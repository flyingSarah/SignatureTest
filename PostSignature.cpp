#include "PostSignature.h"

PostSignature::PostSignature(QObject *parent) : QObject(parent),
    m_manager(new QNetworkAccessManager(this))
{
    connect(m_manager, &QNetworkAccessManager::finished, this, &PostSignature::onReplyFinished);
}

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

void PostSignature::sendPostRequest(QJsonDocument data)
{
    QNetworkRequest request(QUrl("https://httpbin.org/post"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    m_manager->post(request, data.toJson());
}

void PostSignature::onReplyFinished(QNetworkReply *reply)
{
    emit signatureReply(reply->error(), reply->errorString());

    reply->deleteLater();
}
