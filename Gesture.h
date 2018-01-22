#pragma once

#include <QObject>
#include <QDebug>
#include <QJsonArray>

class Gesture : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QJsonArray gesture READ getGesture WRITE appendSegment)

public:
    Gesture(QObject *parent = nullptr);

    Q_INVOKABLE QJsonArray getGesture();
    Q_INVOKABLE void appendSegment(QJsonArray gestureSegment);
    Q_INVOKABLE void clear();

private:
    QJsonArray m_gesture;

};
