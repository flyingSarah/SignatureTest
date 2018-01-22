#pragma once

#include <QObject>
#include <QDebug>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>
#include <QtNetwork>

class PostSignature : public QObject
{
    Q_OBJECT

public:
    PostSignature(QObject *parent = nullptr);

    Q_INVOKABLE QJsonDocument parseData(QJsonArray gesture, int time, int tries);
    Q_INVOKABLE void sendPostRequest(QJsonDocument data);

public slots:
    void onReplyFinished(QNetworkReply *reply);

signals:
    void signatureReply(int status, QString error);

private:
    QScopedPointer<QNetworkAccessManager> m_manager;
};
