#include "SignTimer.h"

SignTimer::SignTimer(QObject *parent) : QObject(parent),
    m_signTime(0) {}

int SignTimer::getSignTime()
{
    return m_signTime;
}

void SignTimer::setSignTime()
{
    m_signTime = m_time->elapsed();
}

void SignTimer::start()
{
    m_signTime = 0;
    m_time = new QTime();
    m_time->start();
}

void SignTimer::stop()
{
    delete m_time;
}
