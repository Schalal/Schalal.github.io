#pragma once
#include"Point.h"
class SimpleSegment
{
private:
	Point startPoint, endPoint;
public:
	SimpleSegment(Point, Point);
	~SimpleSegment();
	double getLength();
};