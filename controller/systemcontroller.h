#ifndef SYSTEMCONTROLLER_H
#define SYSTEMCONTROLLER_H

#include <QObject>
#include <QTimer>

class SystemController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentTime READ currentTime WRITE setCurrentTime NOTIFY currentTimeChanged)

public:
    explicit SystemController(QObject *parent = nullptr);
    QString currentTime() const;

signals:
    void currentTimeChanged(QString currentTime);

public slots:
    void setCurrentTime(QString currentTime);
    void currentTimeTimerTimeout();

private:
    QString m_currentTime;
    QTimer *m_CurrentTimeTimer;
};

#endif // SYSTEMCONTROLLER_H
