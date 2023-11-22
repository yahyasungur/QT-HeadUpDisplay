#ifndef AIMCURSORCONTROLLER_H
#define AIMCURSORCONTROLLER_H

#include <QObject>
#include <QTimer>

class AimCursorController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int cursorDeviationX READ cursorDeviationX WRITE setCursorDeviationX NOTIFY cursorDeviationXChanged)
    Q_PROPERTY(int cursorDeviationY READ cursorDeviationY WRITE setCursorDeviationY NOTIFY cursorDeviationYChanged)

public:
    explicit AimCursorController(QObject *parent = nullptr);
    Q_INVOKABLE void updateDeviation();
    int cursorDeviationX() const;
    int cursorDeviationY() const;

signals:
    void cursorDeviationXChanged(int cursorDeviationX);
    void cursorDeviationYChanged(int cursorDeviationY);

public slots:
    void setCursorDeviationX(int cursorDeviationX);
    void setCursorDeviationY(int cursorDeviationY);

private:
    QTimer m_timer;
    int m_cursorDeviationX;
    int m_cursorDeviationY;
};

#endif // AIMCURSORCONTROLLER_H
