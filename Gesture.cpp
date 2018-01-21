#include "Gesture.h"

Gesture::Gesture(QObject *parent) : QObject(parent) {}

QJsonArray Gesture::getGesture()
{
    return m_gesture;
}

void Gesture::appendSegment(QJsonArray gestureSegment)
{
    m_gesture.append(gestureSegment);
}

void Gesture::clear()
{
    m_gesture.empty();
}

bool Gesture::print(QJsonArray gesture)
{
    qDebug() << gesture;
}
