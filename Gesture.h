#ifndef GESTURE_H
#define GESTURE_H

#include <QObject>
#include <QDebug>
#include <QJsonArray>

class Gesture : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QJsonArray gesture READ getGesture WRITE appendSegment)

public:
    Gesture(QObject *parent = 0);

    Q_INVOKABLE QJsonArray getGesture();
    Q_INVOKABLE void appendSegment(QJsonArray gestureSegment);
    Q_INVOKABLE void clear();

    Q_INVOKABLE bool print(QJsonArray gesture);

private:
    QJsonArray m_gesture;

};

#endif // GESTURE_H
