
import 'package:flutter/material.dart';
import 'package:platform137/providers/gpu.provider.dart';
import 'package:platform137/widgets/fans/fans_analytics.widget.dart';
import 'package:provider/provider.dart';

class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final gpuCount = Provider.of<GPUProvider>(context, listen: false).numOfGPUs;

    return Center(
                  child: SizedBox(
                    // heightFactor: .3,
                    // widthFactor: 1,
                    height: 180,
                    width: double.infinity,
                    
                    child: Container(
                      decoration: const BoxDecoration(color: Color.fromARGB(255, 255, 253, 249)),
                      child: Center(
                        child: Row /*or Column*/( 
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  <Widget>[
                            Icon(Icons.star, size: 50),
                            Icon(Icons.star, size: 50),
                            // Icon(Icons.star, size: 50),
                            if (gpuCount > 1)...[
                              const SizedBox(height: 100, width: 100, 
                                child: FanAnalyticsWidget(gpuIndex: 0)
                              ),
                              const SizedBox(height: 100, width: 100, 
                                child: FanAnalyticsWidget(gpuIndex: 1)
                              ),
                            ] else...[
                              const SizedBox(height: 100, width: 100, 
                                child: FanAnalyticsWidget(gpuIndex: 0)
                              ),
                            ],
                            Text(
                              'platform137',
                              style: Theme.of(context).textTheme.headline1
                            ),
                            Icon(Icons.star, size: 50),
                            Icon(Icons.star, size: 50),
                            Icon(Icons.star, size: 50),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
  }
}
