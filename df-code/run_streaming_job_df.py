import apache_beam as beam
from apache_beam.io.gcp.bigquery import WriteToBigQuery
from apache_beam.options.pipeline_options import PipelineOptions
from apache_beam.io import ReadFromText
import csv

# Define your Dataflow pipeline options
options = PipelineOptions(
    runner='DataflowRunner',
    project='de-gcp-201',
    region='us-central1',
    temp_location='gs://de-ops-201/temp',
    staging_location='gs://de-ops-201/staging',
    job_name='gcs-csv-to-bigquery',
    num_workers=3,
    max_num_workers=10,
    disk_size_gb=100,
    autoscaling_algorithm='THROUGHPUT_BASED',
    machine_type='n1-standard-4',
    service_account_email='pipelines-to-profits-sa@de-gcp-201.iam.gserviceaccount.com'
)

# Define the schema for the BigQuery table
netflix_schema = {
    'fields': [
        {'name': 'show_id', 'type': 'STRING'},
        {'name': 'type', 'type': 'STRING'},
        {'name': 'title', 'type': 'STRING'},
        {'name': 'director', 'type': 'STRING'},
        {'name': 'cast', 'type': 'STRING'},
        {'name': 'country', 'type': 'STRING'},
        {'name': 'date_added', 'type': 'STRING'},
        {'name': 'release_year', 'type': 'INTEGER'},
        {'name': 'rating', 'type': 'STRING'},
        {'name': 'duration', 'type': 'STRING'},
        {'name': 'listed_in', 'type': 'STRING'},
        {'name': 'description', 'type': 'STRING'}
    ]
}

# Function to parse CSV lines into a dictionary
def parse_csv_line(line):
    fields = [
        'show_id', 'type', 'title', 'director', 'cast', 'country',
        'date_added', 'release_year', 'rating', 'duration', 'listed_in', 'description'
    ]
    reader = csv.DictReader([line], fieldnames=fields)
    return next(reader)

# Define your Beam pipeline
with beam.Pipeline(options=options) as pipeline:
    # Read the CSV file from GCS
    csv_lines = pipeline | 'Read CSV from GCS' >> ReadFromText('gs://de-ops-201/netflix_titles.csv', skip_header_lines=1)

    # Parse the CSV lines
    parsed_data = csv_lines | 'Parse CSV Lines' >> beam.Map(parse_csv_line)

    # Write the data to BigQuery
    parsed_data | 'Write to BigQuery' >> WriteToBigQuery(
        table='de-gcp-201:dataflowtest.netflix_titles',
        schema=netflix_schema,
        create_disposition=beam.io.BigQueryDisposition.CREATE_IF_NEEDED,
        write_disposition=beam.io.BigQueryDisposition.WRITE_APPEND
    )
