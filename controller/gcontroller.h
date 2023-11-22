#ifndef GCONTROLLER_H
#define GCONTROLLER_H

#include <QObject>
#include <QTimer>

class GController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double currentG READ currentG WRITE setCurrentG NOTIFY currentGChanged)

public:
    explicit GController(QObject *parent = nullptr);
    double currentG() const;
    Q_INVOKABLE void updateG();

signals:
    void currentGChanged(double currentG);

public slots:
    void setCurrentG(double currentG);

private:
    double m_currentG;
    QTimer m_timer;
};

#endif // GCONTROLLER_H
