#ifndef SIGNTIMER_H
#define SIGNTIMER_H

#include <QObject>
#include <QDebug>
#include <QElapsedTimer>

class SignTimer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int signTime READ getSignTime)

public:
    SignTimer(QObject *parent = 0);

    Q_INVOKABLE int getSignTime();
    Q_INVOKABLE void setSignTime();
    Q_INVOKABLE void start();
    Q_INVOKABLE void stop();

private:
    QElapsedTimer m_timer;
    int m_signTime;

};

#endif // SIGNTIMER_H
