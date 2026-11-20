import sys,unittest
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/"src"))
import pipeline
class PipelineTests(unittest.TestCase):
 @classmethod
 def setUpClass(cls): cls.d=pipeline.load()
 def test_kpi_ranges(self):
  _,_,m=pipeline.calculate(self.d); self.assertGreaterEqual(m["on_time_delivery_pct"],0); self.assertLessEqual(m["on_time_delivery_pct"],100)
 def test_forecast_horizon(self): self.assertEqual(len(pipeline.forecast(self.d,7)),len(self.d["products"])*7)
 def test_what_if_nonnegative(self): self.assertTrue((pipeline.what_if(self.d,7).projected_stock>=0).all())
if __name__=="__main__": unittest.main()
