
import 'package:flutter/material.dart';
import 'package:platform137/providers/gpu.provider.dart';
import 'package:platform137/widgets/fans/fans_analytics.widget.dart';
import 'package:platform137/widgets/temperature/temp_analytics.widget.dart';
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'STATS FROM OFFICIAL DRIVERS',
                                  style: Theme.of(context).textTheme.bodySmall
                                ),
                                Text("ALPHA RELEASE", style: Theme.of(context).textTheme.headline5),
                                Divider(),
                                
                              ],
                            ),
                            // Icon(Icons.star, size: 50),
                            if (gpuCount > 1)...[
                             const SizedBox(height: 100, width: 100, 
                                child: TempAnalyticsWidget(gpuIndex: 0)
                              ),
                              const SizedBox(height: 100, width: 100, 
                                child: TempAnalyticsWidget(gpuIndex: 1)
                              ),
                              const SizedBox(height: 100, width: 100, 
                                child: FanAnalyticsWidget(gpuIndex: 0)
                              ),
                              const SizedBox(height: 100, width: 100, 
                                child: FanAnalyticsWidget(gpuIndex: 1)
                              ),
                            ] else...[
                              const SizedBox(height: 100, width: 100, 
                                child: TempAnalyticsWidget(gpuIndex: 0)
                              ),
                              const SizedBox(height: 100, width: 100, 
                                child: FanAnalyticsWidget(gpuIndex: 0)
                              ),
                            ],
                            // Text(
                            //   ' x137 ',
                            //   style: Theme.of(context).textTheme.headline1
                            // ),
                            Image.network(
                              "https://cryptologos.cc/logos/ergo-erg-logo.png",
                              // color: Colors.red,
                              height: 37,
                              width: 37,
                            ),
                             Image.network(
                              "https://www.mascotdb.com/sites/default/files/images/logos/gillespie.gif",
                              // color: Colors.red,
                              height: 37,
                              width: 37,
                            ),
                            // const Icon(Icons.ac_unit, size: 37),
                            // const Icon(Icons.air, size: 37),
                            //  Text(
                            //   'autolykos - BETA - ERGO',
                            //   style: Theme.of(context).textTheme.bodySmall
                            // ),
    
                          ],
                        ),
                      ),
                    ),
                  ),
                );
  }
}
