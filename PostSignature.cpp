#include "PostSignature.h"

PostSignature::PostSignature(QObject *parent) : QObject(parent),
    m_manager(new QNetworkAccessManager(this))
{
    connect(m_manager.data(), &QNetworkAccessManager::finished, this, &PostSignature::replyFinished);
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
    QNetworkRequest request(QUrl("https://putsreq.com/F8PsIYZ0cD3edRbaa9Rb"));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    m_manager.data()->post(request, data.toJson());
    //QJsonObject testObj;
    //testObj.insert("fail", ":(");
    //QJsonDocument testDoc(testObj);
    //m_manager.data()->post(request, testDoc.toJson());
}

void PostSignature::replyFinished(QNetworkReply *reply)
{
    if(!reply->error())
    {
        QByteArray responseData = reply->readAll();
        QJsonDocument json = QJsonDocument::fromJson(responseData);
        qDebug() << json;
    }

    emit signatureReply(reply->error(), reply->errorString());

    reply->deleteLater();
}
