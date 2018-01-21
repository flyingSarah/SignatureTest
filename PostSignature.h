#ifndef POSTSIGNATURE_H
#define POSTSIGNATURE_H

#include <QObject>
#include <QDebug>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>

class PostSignature : public QObject
{
    Q_OBJECT
public:
    PostSignature(QObject *parent = 0);

    Q_INVOKABLE QJsonDocument parseData(QJsonArray gesture, int time, int tries);
    Q_INVOKABLE bool sendPostRequest(QJsonDocument data);
};

#endif // POSTSIGNATURE_H
