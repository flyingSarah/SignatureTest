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
    while(m_gesture.count())
    {
        m_gesture.pop_back();
    }
}

bool Gesture::print(QJsonArray gesture)
{
    qDebug() << gesture;
}
