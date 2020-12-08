import './modules/display';
import { addWidget } from './modules/display';
import { testWidget } from './modules/widgets/test';
import { clockWidget } from './modules/widgets/clock';

addWidget(testWidget(10, 27, 8, 1));
addWidget(testWidget(18, 33, 4, 2));

addWidget(clockWidget(-5, 2, 3));
