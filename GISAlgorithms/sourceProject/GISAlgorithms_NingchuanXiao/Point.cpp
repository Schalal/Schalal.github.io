#include "Point.h"
Point::Point(int x, int y)
{
	this->x = x;
	this->y = y;
	type = INTPOINT;
}
Point::Point(double x, double y)
{
	this->x = x;
	this->y = y;
	type = DOUBLEPOINT;
}
Point::~Point()
{
}
int Point::getDimension()
{
	return 2;
}
int Point::getItem(int order)
{
	switch (order)
	{
	case 0:return x;
	case 1:return y;
	default: return 0;
	}
}
bool Point::isEqual(Point other)
{
	if (this->type != other.type)
		return false;
	if (this->type == INTPOINT)
	{
		if (this->x == other.x && this->y == other.y)
		{
			return true;
		}
	}
	else if (abs(this->x - other.x) < eps && abs(this->y - other.y) < eps)
		return true;
	return false;
}
bool Point::isDifferent(Point other)
{
	if (isEqual(other))
		return false;
	else return true;
}
bool Point::isGreaterThan(Point other)
{
	if (this->x > other.x)
		return true;
	else if (this->x == other.x && this->y > other.y)
		return true;
	else return false;
}
bool Point::isLessThan(Point other)
{
	if (this->x < other.x)
		return true;
	else if (this->x == other.x && this->y < other.y)
		return true;
	else return false;
}
string Point::getXYString()
{
	return "("+to_string(x)+","+to_string(y)+")";
}
double Point::getEuclideanDistance(Point other)
{
	return sqrt(pow(x-other.x,2)+pow(y-other.y,2));
}
double Point::getManhattanDistance(Point other)
{
	return abs(x - other.x) + abs(y - other.y);
}
double Point::getGreatCircleDistance(Point other)
{
	double phi_1 = radian(y);
	double phi_2 = radian(other.y);
	double lamda_1 = radian(x);
	double lamda_2 = radian(other.x);
	double a = pow(sin((phi_1 - phi_2)/2.0), 2) + cos(phi_1) * cos(phi_2)* pow(sin((lamda_1 - lamda_2) / 2.0), 2);
	return 2 * radius * asin(min(1.0, sqrt(a)));
}
template <class T> double radian(T degree)
{
	return double(degree) * pi / 180;
};