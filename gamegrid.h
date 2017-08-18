/*
MIT License

Copyright (c) 2017 Boris Martin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
#ifndef GAMEGRID_H
#define GAMEGRID_H

#include <QList>
#include <QLinkedList>
#include <QPair>

/** @brief Class storing the data on a Grid.
 *
 *  This class stores the state of a square Snake Grid, with a constant 2D size, safe access, food generation option,...
 *
 *
 * */
class GameGrid : public QObject
{
    using Snake = QLinkedList<QPair<int, int>>;

    Q_OBJECT

    Q_PROPERTY(int width READ width)
    Q_PROPERTY(int heigth READ heigth)

public:
    GameGrid(int w = 12, int h = 8);

    enum CELL_STATE {EMPTY, SNAKE, FOOD};
    enum DIRECTION {LEFT, UP, RIGHT, BOTTOM};
    Q_ENUM(CELL_STATE)
    Q_ENUM(DIRECTION)

    const int m_width;
    const int m_height;

public slots:

    int width() const {
        return m_width;
    }

    int heigth() const {
        return m_height;
    }

    /**
     * @brief headPos
     * @return the ID (x + y*w) of the cell containing snake's head
     */
    int headPos() const {
        auto& head = snake.last();
        return head.first + m_width * head.second;
    }

    /**
     * @brief read cell state at particular coordinates
     * @param x : absciss, such as 0 <= x < width
     * @param y : ordinate, such as 0 <= x < heigth
     * @return state at this cell, CELL_STATE::EMPTY if out of bound.
     */
    CELL_STATE at(int x, int y) const;

    /**
     * @brief switch an empty cell to FOOD state, randomly
     */
    void addFood();

    /**
     * @brief advance
     * @param d : direction to move the snake.
     */
    void advance(DIRECTION d);

    void toStdOut() const;

signals:
    /**
     * @brief emitted when data changes. Parameter is the ID of the cell changed, -1 if more than one changed.
     */
    void changed(int);

    /**
     * @brief Emitted when the game ends. Parameter is the snake size.
     */
    void lost(int);

    /**
     * @brief Emitted when snake size == Grid size
     */
    void won();

    /**
     * @brief Emitted when the snake tries to go exactly behind his head
     */
    void failedDirectionSwitch();

private:
    QList<CELL_STATE> data;
    //Linked list of cells. First is the tail, last the head
    Snake snake;
    int foodLocation = 0;

    void initSnake();
    void updateGrid();
};

#endif // GAMEGRID_H
