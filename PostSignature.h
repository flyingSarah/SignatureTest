#ifndef POSTSIGNATURE_H
#define POSTSIGNATURE_H

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
    PostSignature(QObject *parent = 0);

    Q_INVOKABLE QJsonDocument parseData(QJsonArray gesture, int time, int tries);
    Q_INVOKABLE void sendPostRequest(QJsonDocument data);

public slots:
    void replyFinished(QNetworkReply *reply);

signals:
    void signatureReply(int status, QString error);

private:
    QNetworkAccessManager *manager;
};

#endif // POSTSIGNATURE_H
